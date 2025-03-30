module 0xc2ecd3a73ddc0536133a97d1d9df0162a6c8a3637ad0e64e9e5d1e2082def69c::sfm {
    struct SFM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFM>(arg0, 6, b"SFM", b"Super FishMan", b"Just a super fish man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052287_cf0c8ffb94.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFM>>(v1);
    }

    // decompiled from Move bytecode v6
}

