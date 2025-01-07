module 0x6a8058c30e8fb44f192596e7c852155e61ec67ba582ba8a795c63828d6c036b2::chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAD>(arg0, 6, b"CHAD", b"Chader", x"20436861646572206973206120646567656e206f6273657373656420776974682068697320686169722e205468657265206973206f6e6c79206f6e65207468696e672074686174206865206861746573206d6f7265207468616e206c6f73696e673a206a656574732e20436861646572206973206c696b6520686973206d7573636c65733a206865206f6e6c792067726f7773206269676765722e20486520697320666561726c6573732e0a0a20496e2066616374206665617220697320616672616964206f662068696d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chader_logo_2822eabf5f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

