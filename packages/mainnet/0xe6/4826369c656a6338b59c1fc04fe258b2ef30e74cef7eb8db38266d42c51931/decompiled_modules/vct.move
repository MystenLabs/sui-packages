module 0xe64826369c656a6338b59c1fc04fe258b2ef30e74cef7eb8db38266d42c51931::vct {
    struct VCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCT>(arg0, 6, b"VCT", b"Valentine Cat", b"Valentine Cat(VCT) is a fun, love-filled memecoin that combines the charms of cats with the excitement of crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031859_6361ebf0bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

