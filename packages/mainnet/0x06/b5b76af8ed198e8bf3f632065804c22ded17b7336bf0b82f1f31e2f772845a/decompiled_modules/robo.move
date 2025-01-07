module 0x6b5b76af8ed198e8bf3f632065804c22ded17b7336bf0b82f1f31e2f772845a::robo {
    struct ROBO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ROBO>, arg1: 0x2::coin::Coin<ROBO>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ROBO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ROBO>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: ROBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBO>(arg0, 6, b"ROBOTON", b"ROBO", b"Each $ROBO is unique and represents a variety of meme themes  https://www.roboton.cloud/  https://x.com/robotonsui  https://t.me/robotonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmWySqTyTzKiQCjWeAxk8TMsSHTipYGaLmo8smSF7Ez7Wa")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<ROBO>, arg1: 0x2::coin::Coin<ROBO>) : u64 {
        0x2::coin::burn<ROBO>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<ROBO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ROBO> {
        0x2::coin::mint<ROBO>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

