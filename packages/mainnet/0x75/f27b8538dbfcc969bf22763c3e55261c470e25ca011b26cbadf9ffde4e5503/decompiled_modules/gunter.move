module 0x75f27b8538dbfcc969bf22763c3e55261c470e25ca011b26cbadf9ffde4e5503::gunter {
    struct GUNTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUNTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUNTER>(arg0, 6, b"GUNTER", b"Gunter", x"47756e7465722c20746865206375746573742070656e6775696e2066726f6d20416476656e747572652054696d65206973206e6f77206f6e205355492e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241202_165754_840_aa3f14a89f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUNTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUNTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

