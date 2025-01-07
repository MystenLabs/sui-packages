module 0x97e0f37cb74da4866ff8f7caff5f7233a7e50037dc7926d3d8ca01c886769392::wang {
    struct WANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANG>(arg0, 6, b"WANG", b"Wang The Orca", b"Ahh, it feels so good to be a KILLER WHALE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wangggg_2344e421cf.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

