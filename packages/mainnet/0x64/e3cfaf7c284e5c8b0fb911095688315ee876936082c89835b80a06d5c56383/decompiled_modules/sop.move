module 0x64e3cfaf7c284e5c8b0fb911095688315ee876936082c89835b80a06d5c56383::sop {
    struct SOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOP>(arg0, 6, b"SOP", b"Sui On Punks", x"302c303030204e465420636f6c6c656374696f6e206c6976696e67206f6e202453756920706f7765726564206279202450756e6b20746f6b656e2c2063726561746564206279200a405375696c6c696f6e616972650a6d656d6520746f6b656e20737569206f6e2070756e6b730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/punk_f3aaf91a75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

