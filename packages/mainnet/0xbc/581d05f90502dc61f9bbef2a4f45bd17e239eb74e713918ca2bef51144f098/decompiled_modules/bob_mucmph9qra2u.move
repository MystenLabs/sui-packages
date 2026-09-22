module 0xbc581d05f90502dc61f9bbef2a4f45bd17e239eb74e713918ca2bef51144f098::bob_mucmph9qra2u {
    struct BOB_MUCMPH9QRA2U has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB_MUCMPH9QRA2U, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB_MUCMPH9QRA2U>(arg0, 9, b"BOB", b"Bobsui", b"Bob is god", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmRy7kNjkKhjKWMd5QhrB83vodmUkaSHQQT3MCKz8wMWzq")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOB_MUCMPH9QRA2U>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB_MUCMPH9QRA2U>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

