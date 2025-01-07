module 0x33d1f8ae43bd5c82f359d9b701f77713bc4c9035f8bbc6b03ffd72ec62cff72d::smurfcat {
    struct SMURFCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURFCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURFCAT>(arg0, 6, b"SMURFCAT", b"Real Smurf Cat", b"This token was created to  some of the SMURFS who has experience lack of appreciation and recognition.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/smurfs_5d42d3534a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURFCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURFCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

