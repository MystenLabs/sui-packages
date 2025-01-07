module 0x610a338fc346b3170775e2e06851111161048cabbb085c5d275368c91c597984::submarine {
    struct SUBMARINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBMARINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBMARINE>(arg0, 6, b"SUBMARINE", b"Submarine On Sui", b"$SUBMARINE dives deep in Suis waters, exploring places others cant.  Its made for those who want to go under the surface and find whats hidden below. Simple, strong, and always moving forward.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Submarine_12d225b47b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBMARINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUBMARINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

