module 0x1601fdf3857d61314022dc7fbf9fb37b243daaba42f4646a1568af5674115577::roboton {
    struct ROBOTON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ROBOTON>, arg1: 0x2::coin::Coin<ROBOTON>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ROBOTON>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ROBOTON>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: ROBOTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOTON>(arg0, 6, b"ROBOTON", b"ROBO", b"Each $ROBO is unique and represents a variety of meme themes, ranging from famous internet moments and viral trends to exclusively designed memes. https://www.roboton.cloud/  https://x.com/robotonsui  https://t.me/robotonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-shocked-dinosaur-182.mypinata.cloud/ipfs/QmWySqTyTzKiQCjWeAxk8TMsSHTipYGaLmo8smSF7Ez7Wa")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROBOTON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOTON>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<ROBOTON>, arg1: 0x2::coin::Coin<ROBOTON>) : u64 {
        0x2::coin::burn<ROBOTON>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<ROBOTON>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ROBOTON> {
        0x2::coin::mint<ROBOTON>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

