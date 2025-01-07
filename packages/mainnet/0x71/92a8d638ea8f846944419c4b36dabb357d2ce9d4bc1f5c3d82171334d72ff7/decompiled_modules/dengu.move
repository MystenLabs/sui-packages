module 0x7192a8d638ea8f846944419c4b36dabb357d2ce9d4bc1f5c3d82171334d72ff7::dengu {
    struct DENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENGU>(arg0, 6, b"DENGU", b"Dengu", x"427a7a7a20427a7a7a7a2074686520696e66656374696f6e2068617320626567756e2e2e2e202464656e677520697320686572652c2050756467696573206172652067726f77696e672077696e677320616e642074616b696e6720666c696768742120200a57616e7420796f7572202470656e677520696e6665637465643f20576174636820746869732073706163652020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053363_29ae10dcd2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

