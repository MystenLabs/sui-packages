module 0xd601edf8c60281f304ab9ee6e72e735049b9d3a2fb35551621842c85d6c7e57a::ran {
    struct RAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAN>(arg0, 6, b"RAN", b"RAN is RAN Future", b"RAN coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blovedapp.com/assets/images/logo-bg-opacity.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

