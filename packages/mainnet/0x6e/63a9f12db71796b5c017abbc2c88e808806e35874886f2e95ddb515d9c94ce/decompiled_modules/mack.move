module 0x6e63a9f12db71796b5c017abbc2c88e808806e35874886f2e95ddb515d9c94ce::mack {
    struct MACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MACK>(arg0, 6, b"MACK", b"Mackerel", b"The humble mackerel, unlike the solitary sharks and mighty whales, thrived by swimming together in great schools, using unity and agility to survive the ocean's dangers. In the end, it was not strength but cooperation and adaptability that brought them fortune.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mack_52201614da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

