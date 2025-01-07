module 0xcfb29dc13b2ae52499abfa3498cc897076988d0848deb0131eed30954e2f1c3f::yak {
    struct YAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAK>(arg0, 9, b"YAK", b"Yakoya", b"New Trend For Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d42789c-78c5-406b-a11f-daf0adc0bb48.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

