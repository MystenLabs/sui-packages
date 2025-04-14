module 0x61428ee1d8b4209ef37f4690664c5e880b9f5a791237a053179f6ce7af3fb3d::dat {
    struct DAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAT>(arg0, 6, b"Dat", b"DAT", b"duck + cat = dat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pump_IMG_1_b6be5e2663.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

