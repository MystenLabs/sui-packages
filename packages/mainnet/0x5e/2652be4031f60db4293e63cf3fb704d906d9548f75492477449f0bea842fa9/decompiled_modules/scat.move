module 0x5e2652be4031f60db4293e63cf3fb704d906d9548f75492477449f0bea842fa9::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"SCAT", b"SCUBA CAT", x"4920616d20746865206f6e6c79206361742074686174206c696b657320646976696e6720696e20746865206465657020626c75652073756921205374617274696e67206f6e204d6f766570756d7020736f20796f7520646f6e2774206e65656420746f20776f727279206173207765206578706c6f7265207468652064656570207365617321205468697320697320746865206f6e6c79207363756261206361742c206d656f77206c6f76657320796f75210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8359217c001cd427735a3a4e5a981e96_f36be05d45.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

