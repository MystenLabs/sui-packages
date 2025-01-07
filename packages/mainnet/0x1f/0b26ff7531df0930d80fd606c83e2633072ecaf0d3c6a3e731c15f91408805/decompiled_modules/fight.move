module 0x1f0b26ff7531df0930d80fd606c83e2633072ecaf0d3c6a3e731c15f91408805::fight {
    struct FIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIGHT>(arg0, 6, b"FIGHT", b"THE GREAT FIGHT", b"Jake Paul will face off against Mike Tyson in this epic boxing showdown. The popular YouTuber turned professional boxer goes head-to-head with a true legend, Iron Mike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ava_4692671cb7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

