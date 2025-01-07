module 0x5216191d52cfaea3a50b873876c83658dc0c199ef140eca73809e7e54c2bec0e::slicker {
    struct SLICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLICKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLICKER>(arg0, 6, b"SLICKER", b"Sui licker", x"244c49434b4552206973206120747275652073746f7279206f662061206d616e2077686f206368616e67656420686973206c69666520746f206265636f6d652072696368210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3551_f3c0599d32.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLICKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLICKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

