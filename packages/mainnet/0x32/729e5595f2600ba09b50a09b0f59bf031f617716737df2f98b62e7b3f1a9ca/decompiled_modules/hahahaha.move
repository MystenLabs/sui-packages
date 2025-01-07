module 0x32729e5595f2600ba09b50a09b0f59bf031f617716737df2f98b62e7b3f1a9ca::hahahaha {
    struct HAHAHAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHAHAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHAHAHA>(arg0, 6, b"Hahahaha", b"Heheheh", x"496e2053756920576f6e6465726c616e642c2074686520426c756520486970706f20636f6e74726f6c73206d61676963616c20626c6f636b636861696e2073747265616d732c20756e6c6f636b696e67207765616c746820616e6420706f7765722e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_49d624615c_9743291c67.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHAHAHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAHAHAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

