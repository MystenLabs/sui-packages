module 0x6b094f677356e668570834a8ae2071f2ade46acb7fdaa532df130011a8c464ca::thirstyinu {
    struct THIRSTYINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: THIRSTYINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THIRSTYINU>(arg0, 6, b"THIRSTYINU", b"Thirsty Shiba Inu", x"546865206f6666696369616c20707570206f66205375692c202454484952535459494e5520697320616c77617973206f6e207468652070726f776c2c207061726368656420616e642063726176696e67206f6e65207468696e67206d6f72652053756921205769746820616e20696e7361746961626c65207468697273742c20746869732053686962617320676f74206974732065796573206c6f636b6564206f6e2065766572792064726f702e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_85_b43087554c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THIRSTYINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THIRSTYINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

