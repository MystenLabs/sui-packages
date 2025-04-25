module 0x17db88f62f137f3d8a548b6462206328d0bc4373e8997e221ef711cb484351ec::drop {
    struct DROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROP>(arg0, 6, b"Drop", b"SkyDrop", b"Ultra Mecha - $DROP Collection Sold out on Venomart. (Now Comin on Multichain). https://venomart.io/collection/0:0d992cf4fdf7a57f7338300456a0bbc3a1fda77a5c32217ffacd39de8308f080", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_25_23_23_38_ee131d168a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

