module 0x3cd0d16eb6f0baaac53fe9ccb4fc9952ca821b2475ad4677070085ceffa1a4d0::eth6900 {
    struct ETH6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETH6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH6900>(arg0, 6, b"ETH6900", b"Ethereum6900", b"HarryPotterObamaSonic10Inu $Ethereum6900 is a playful and nostalgic memecoin that combines pop culture references with the original Ethereum spirit. As an OG Ethereum-inspired token, it embraces the fun side of crypto while paying homage to its decentralized roots.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ethereum6900_2ac3475a56.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETH6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETH6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

