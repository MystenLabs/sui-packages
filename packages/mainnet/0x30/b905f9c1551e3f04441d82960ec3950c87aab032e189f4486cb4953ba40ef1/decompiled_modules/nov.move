module 0x30b905f9c1551e3f04441d82960ec3950c87aab032e189f4486cb4953ba40ef1::nov {
    struct NOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOV>(arg0, 6, b"NOV", b"SuiNova", b"SuiNova is a cutting-edge cryptocurrency built on the SUI blockchain, designed to empower users with unparalleled speed, scalability, and innovation. Inspired by the brilliance of a nova, SuiNova shines as a beacon of opportunity within the SUI ecosystem, offering seamless transactions and robust utility for decentralized applications. With its sleek design and forward-thinking vision, SuiNova aims to fuel the next wave of financial freedom, blending performance with accessibility. Whether you're a developer, investor, or enthusiast, SuiNova is your gateway to a brighter, faster, and more connected digital economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2461833a95.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOV>>(v1);
    }

    // decompiled from Move bytecode v6
}

