module 0xeeb16da2b1dd435390a754233317e7890da751a55a6fd3ae4ee9847a95c0d216::lou {
    struct LOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOU>(arg0, 6, b"LOU", b"Lou", x"49e280996d206a7573742061206375746520646f672074686174206c696b657320746f2074616b6520706963747572657320696e20646966666572656e742073657474696e67732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735074202309.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

