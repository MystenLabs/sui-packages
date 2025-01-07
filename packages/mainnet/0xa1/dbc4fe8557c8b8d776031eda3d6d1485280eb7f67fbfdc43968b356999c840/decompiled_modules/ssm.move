module 0xa1dbc4fe8557c8b8d776031eda3d6d1485280eb7f67fbfdc43968b356999c840::ssm {
    struct SSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSM>(arg0, 6, b"SSM", b"Sui Santa Mascot", b"Sui Santa Mascot is a cheerful water mascot donning an iconic Santa hat, spreading festive joy and warmth. A playful symbol of freshness and celebration, it brings waves of happiness and togetherness to the community. Join the fun and ride the festive wave with this charming and unforgettable mascot!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050955_d6fd50e709.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

