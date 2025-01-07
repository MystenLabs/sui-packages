module 0xab80a40f29003534acbe9279046536e947d073f4d3679ce1ff0cf285c7eab379::bwedmask {
    struct BWEDMASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWEDMASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWEDMASK>(arg0, 6, b"bwedMask", b"Dwag WiF BwedMask", x"4f766572206f6e20496e7374616772616d2c207573696e6720686173687461677320696e636c7564696e6720236272656164666163652c2070656f706c652068617665206265656e2073686172696e672070686f746f73206f6620746865697220676f6f6420626f797320616e64206769726c732077656172696e67206d61736b73206d6164652066726f6d20736c69636573206f6620627265616420617320796f7520646f2e0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_19_41_53_7cde81ffb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWEDMASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWEDMASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

