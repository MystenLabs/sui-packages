module 0x2f994762363bddef8987a87b9445a90a5ae18cd88ac655ee7d7bec514731f26f::pvs {
    struct PVS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PVS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PVS>(arg0, 6, b"PVS", b"Patience is a Virtue", b"With Sui blockchain memecoins, patience is particularly essential. These coins often rely on community support and engagement to thrive. Projects built on Sui can develop over time, fostering organic growth rather than relying solely on short-term hype. As communities rally around these coins, they can drive real value and create lasting ecosystems. Happy Trading Socials will be sent to Threads here. for now enjoy the website.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/piv_16f472ada9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PVS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PVS>>(v1);
    }

    // decompiled from Move bytecode v6
}

