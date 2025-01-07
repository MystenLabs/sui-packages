module 0xfa35e6833d1ffd075220aacfe780f1e36fd01515ac9ed3d83e722fbcb5e71884::aaad {
    struct AAAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAD>(arg0, 6, b"AAAD", b"AAA Doge", b"AAA Doge - Can't stop Won't stop thinking about Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_06_T174715_084_2f40bae336.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

