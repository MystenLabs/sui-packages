module 0x53183f4fe583a99de68c9885ce3af6685da53890cd06d8c9a2b4f6e034a6d456::chippy {
    struct CHIPPY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHIPPY>, arg1: 0x2::coin::Coin<CHIPPY>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHIPPY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHIPPY>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: CHIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIPPY>(arg0, 6, b"$CHIP", b"Chippy", b"DRAMATIC CHIPPY $CHIP IS A VIRAL INTERNET 5-SECOND CLIP OF A PRAIRIE DOG   https://chipppy.xyz/  https://x.com/ChippySuii   https://t.me/chippysui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeidcgjar2x4llgvrxok44udsm2knk7m74fjtdyyg6xxoal6xwtvvri.ipfs.web3approved.com/?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjaWQiOiJiYWZ5YmVpZGNnamFyMng0bGxndnJ4b2s0NHVkc20ya25rN203NGZqdGR5eWc2eHhvYWw2eHd0dnZyaSIsInByb2plY3RfdXVpZCI6IjAyMDEwOTM4LTZiODItNDg0NC1hOTBmLTQ0NzBmOGJmOTM0ZCIsImlhdCI6MTcyODczMDkxNCwic3ViIjoiSVBGUy10b2tlbiJ9.jXRCgsm8tmJBKXIYzUfJ-KWb3qcwgWs9P1Jtjzm2tbk")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIPPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<CHIPPY>, arg1: 0x2::coin::Coin<CHIPPY>) : u64 {
        0x2::coin::burn<CHIPPY>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<CHIPPY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CHIPPY> {
        0x2::coin::mint<CHIPPY>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

