module 0x1937761dc9e365ebf29a3fad1b79528bf0f94b15131d10cc8d18a8a4a336420d::tentacat {
    struct TENTACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENTACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENTACAT>(arg0, 6, b"TENTACAT", b"Tentacat", x"546865206d7574616e7420646567656e206f66205375692c20626f726e2066726f6d206c69717569646174696f6e7320616e6420626164206465636973696f6e732e204569676874206c6567732c207a65726f206d657263792e205768696c6520746865206d61726b65742064726f776e732c2054454e544143415420636c696d62732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tentacat_logo_b7fd8cd5bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENTACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TENTACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

