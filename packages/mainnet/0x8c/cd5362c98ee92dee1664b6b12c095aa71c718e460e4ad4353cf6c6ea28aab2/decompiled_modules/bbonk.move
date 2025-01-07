module 0x8ccd5362c98ee92dee1664b6b12c095aa71c718e460e4ad4353cf6c6ea28aab2::bbonk {
    struct BBONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBONK>(arg0, 6, b"BBONK", b"BlubBonk Sui", b"The best memes & tokenomics on $Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241006_022723_75f06b06ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

