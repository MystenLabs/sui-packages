module 0xd0699cfd13b59d7bd4cd5442787876d1ddc1a7a90e0ac9916cf1365b98dd8bf3::qiqi {
    struct QIQI has drop {
        dummy_field: bool,
    }

    fun init(arg0: QIQI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QIQI>(arg0, 6, b"Qiqi", b"QiqiBaiji", b"My name Qiqi the last known living Baiji dolphin of Yangtze River in China", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000090042_c8f5eacf01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QIQI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QIQI>>(v1);
    }

    // decompiled from Move bytecode v6
}

