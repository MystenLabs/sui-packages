module 0x8356271814da1506e8283b7f8fc68ab60f12f553e7a944442d5cc5ec9c83a337::rtc {
    struct RTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTC>(arg0, 9, b"RTC", b"$RTC", b"New project 2025: SATOSHI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8a9f27e2eef9cbf4aa1b0b6e42657b20blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

