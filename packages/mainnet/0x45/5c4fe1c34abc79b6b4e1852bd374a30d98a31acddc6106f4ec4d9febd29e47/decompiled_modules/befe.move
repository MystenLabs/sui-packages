module 0x455c4fe1c34abc79b6b4e1852bd374a30d98a31acddc6106f4ec4d9febd29e47::befe {
    struct BEFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEFE>(arg0, 6, b"BEFE", b"Befe Sui", x"42454645206f6e20535549202d205468652066756e6e6965737420616e64206d6f7374206d656d652d776f727468792063727970746f2065766572212054686520646f67677920262066726f6720636f696e7320686164207468656972206d6f6d656e742c20627574206e6f7720697473204245464573207475726e20746f207368696e6520616e64206265636f6d652074686520756c74696d617465206d656d65206b696e672e0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/black_box_be1859e67d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

