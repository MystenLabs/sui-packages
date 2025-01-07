module 0x3ee92ca345a6398df2e35d185d9a8579c7137c8f39c7055b4e9770c985d5d989::mdr {
    struct MDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDR>(arg0, 6, b"MDR", b"MetaDragon", b"The image of a dragon wearing VR glasses can represent a mythical creature stepping into the modern world, bridging the gap between tradition and the future. It symbolizes the dragon as the guardian of digital assets, ensuring safety and transparency in blockchain transactions. Additionally, the VR dragon can serve as a metaphor for groundbreaking technology and the limitless exploration potential of the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DNTT_e8d27e94ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

