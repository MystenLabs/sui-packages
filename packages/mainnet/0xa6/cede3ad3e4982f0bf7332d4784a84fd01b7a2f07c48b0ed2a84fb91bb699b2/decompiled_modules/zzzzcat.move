module 0xa6cede3ad3e4982f0bf7332d4784a84fd01b7a2f07c48b0ed2a84fb91bb699b2::zzzzcat {
    struct ZZZZCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZZZCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZZZCAT>(arg0, 6, b"ZZZZCAT", b"SnoozeCat", b"Our choice to launch on SUI, instead of Solana, comes down to two key factors: SUI's unique architecture and scalability, plus the opportunity to stand out in a less crowded ecosystem. SUIs design prioritizes ultra-fast transaction finality and minimal costs, perfectly matching our goal to deliver an exceptional, high-performance platform. With SUI, were setting SnoozeCat up for seamless growth and innovation. Stay tuned for whats next", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043380_991a229d17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZZZCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZZZZCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

