module 0x4f113e576ee452f5e9125ab6e2b86413f18720f402a55ec8243ee0a3fb6565c1::croak {
    struct CROAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROAK>(arg0, 6, b"Croak", b"Sui Croak", b"CroakCroakCroakCroakCroakCroakCroakCroakCroakCroakCroak", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WX_20241012_231643_3704c40e3d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

