module 0xd269c90b5499e6418b9d4bf44484b74b9233de14ff129f061e82d5fffe1a98da::rbg {
    struct RBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBG>(arg0, 8, b"RBG", b"Ascifiw3 network ", b"A community token to fund activities of people sharing a common goal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/932b7880-f787-11ef-969d-95699ee2ef92")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBG>>(v1);
        0x2::coin::mint_and_transfer<RBG>(&mut v2, 110000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBG>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

