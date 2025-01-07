module 0xa71c02feedf849ec8f9de512db742720d1934efbc606132c30cf6633235e01ab::wdog {
    struct WDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDOG>(arg0, 6, b"WDOG", b"WealthyDOG", b"Congratulations on discovering us. This will be your second chance to create wealth. Careful people will always gain a lot of things, including wealth!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dog_e0a17a568c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

