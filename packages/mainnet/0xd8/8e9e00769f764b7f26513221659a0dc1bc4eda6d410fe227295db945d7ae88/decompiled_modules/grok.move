module 0xd88e9e00769f764b7f26513221659a0dc1bc4eda6d410fe227295db945d7ae88::grok {
    struct GROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROK>(arg0, 6, b"GROK", b"Grok", b"Grok SUI is a memecoin inspired by a unique character with a horned helmet and a distinctive blue theme. This token is created for a community that wants to have fun while investing in the crypto world. Grok SUI has visual and symbolic appeal, representing a spirit of camaraderie and adventure within the SUI blockchain ecosystem. This token is perfect for memecoin enthusiasts who want to connect in a solid and dynamic community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241104_001856_d48818716c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

