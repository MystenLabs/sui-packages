module 0xab25e89fa0459bab7fde5ba5f564e264c2c7878396038c66bb2c6c97076eb95a::aka {
    struct AKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKA>(arg0, 6, b"AKA", b"EKE", b"IPI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/0885f9d6-d7c6-4ae0-9eb6-a8b7f6298b24.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AKA>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

