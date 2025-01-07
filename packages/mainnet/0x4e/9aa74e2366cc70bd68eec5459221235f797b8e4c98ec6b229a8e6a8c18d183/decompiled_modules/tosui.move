module 0x4e9aa74e2366cc70bd68eec5459221235f797b8e4c98ec6b229a8e6a8c18d183::tosui {
    struct TOSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOSUI>, arg1: 0x2::coin::Coin<TOSUI>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOSUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TOSUI>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: TOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOSUI>(arg0, 6, b"TOSUI", b"Toshi On Sui", b"TOSHI SUI - LEADING MEME SUI CHAIN   https://www.tosui.cloud/  https://x.com/toshionsui   https://t.me/toshionsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmWStFjLsqwgVkwQmedvgZ5kRbTfdps8pfBJPeSCqkq7D6")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<TOSUI>, arg1: 0x2::coin::Coin<TOSUI>) : u64 {
        0x2::coin::burn<TOSUI>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<TOSUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TOSUI> {
        0x2::coin::mint<TOSUI>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

