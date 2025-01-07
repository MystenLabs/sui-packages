module 0x8d9c26caa4a1e66a67421c7207313df8de960df85d83d7917ef5f431d6dc275f::ket {
    struct KET has drop {
        dummy_field: bool,
    }

    fun init(arg0: KET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KET>(arg0, 6, b"KET", b"SUI Ket", b"When you realize $KET isn't just another token it's your ticket to the purr-fect success", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kett_377c65392b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KET>>(v1);
    }

    // decompiled from Move bytecode v6
}

