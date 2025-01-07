module 0xe560808b701b0c1a83806a91bf1b63232029e2826b55ddfc182de6d57d72c28f::harriscat {
    struct HARRISCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARRISCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARRISCAT>(arg0, 6, b"HarrisCat", b"Harris With Cat", x"546f206265204265737420506f6c6974696373206d656d65206f6e207375692e2069742070756d7020746f20242031622077697468206e6f20736f6369616c206368616e6e656c200a70756d7021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/camalacat_eecf185dc9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARRISCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARRISCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

