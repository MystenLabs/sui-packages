module 0x199b2bd91bb2b2a0a2fef7c7aef313ff05fc2a182740f3492402415e284483a3::gus {
    struct GUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUS>(arg0, 6, b"GUS", b"Groggy Gus", b"...from rum to riches with every stumble... Arrrrr welcome aboard! www.groggygus.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/33_8dc2cf14e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

