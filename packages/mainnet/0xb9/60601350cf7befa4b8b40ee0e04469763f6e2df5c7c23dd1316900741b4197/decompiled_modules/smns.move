module 0xb960601350cf7befa4b8b40ee0e04469763f6e2df5c7c23dd1316900741b4197::smns {
    struct SMNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMNS>(arg0, 9, b"SMNS", b"Simens", b"Dedicated to da real hero Sanek Simen aka Duralei Simen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1a150509e5a88d4fa95eff236c1430c7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMNS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMNS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

