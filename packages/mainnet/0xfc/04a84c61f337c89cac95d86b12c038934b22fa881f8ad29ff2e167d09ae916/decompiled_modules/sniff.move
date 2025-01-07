module 0xfc04a84c61f337c89cac95d86b12c038934b22fa881f8ad29ff2e167d09ae916::sniff {
    struct SNIFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIFF>(arg0, 6, b"SNIFF", b"Sniffles", x"536e6966666c6573206275726965642068697320626f6e6520736f6d6577686572652c206275742068652063616e742072656d656d6265722077686572652e2e0a4a6f696e207468652053656172636820616e642068656c702068696d2066696e642069742c2074686520736f6f6e6572207468652062657474657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_11cf0a3d90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNIFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

