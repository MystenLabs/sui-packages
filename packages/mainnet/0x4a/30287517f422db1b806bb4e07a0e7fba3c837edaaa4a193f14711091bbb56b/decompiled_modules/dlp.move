module 0x4a30287517f422db1b806bb4e07a0e7fba3c837edaaa4a193f14711091bbb56b::dlp {
    struct DLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLP>(arg0, 8, b"DLP", b"DolphinDime", b"gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnCvZh5WN6lY6AN0tZLjYu6_MNBRP_o4yqExX1icZNwSn31AMXvmRbYyM1sMkQ8Tq55Ys&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DLP>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DLP>>(v1);
    }

    // decompiled from Move bytecode v6
}

