module 0xb223936d809c557615535ae28b49bbacd6d81034d8db8bb46963dd100feaee62::bill {
    struct BILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<BILL>(arg0, 6, b"BILL", b"DuckBill", x"4c696b6520746865206475636b20e280942063616c6d206f6e2074686520737572666163652c20737769667420756e6465726e65617468", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRooDAABXRUJQVlA4IH4DAACwFACdASqAAIAAPm02mEikIyKhIxgJgIANiWUKFrQVYcutuIFcF9AG2V5rfUXN6J/ZL9gLMZ/Jcqkfhfffxz/KPnVlhnGO2t/gPQDSU4y/QDz5MzP9YBlOsA/rM7ypAtKNuLSwzO5eEDVWQdaX25y3Hc6UupeVxx+Ed1YpGkLjVI9ip0lqvYVVlCNbxWdL6vxoD6dRV3fcDoolK3wH2qEbADHDuFlVYB/WZ3lSBAAA/v+IL0QKnvdZCASP7xPn/wbut3n863SjfS1TU7bc0RfAECSilInoaELuynaWiwpkvLAAGzcYgfRFdYzC+YzVuW+4v5LqZxMVsd22gYsK8eaWzcPSNRbVztlxeyIZq+oQ0SU6r5mdfDCTOXg9PqE+f3FoR5tcKemZby3V1OnQVrlb5D3w1k33u29wIuXd7/3vKobNEzVhgZpdIB20vTDrG4T7JXcRVoAOQZk11YBnofV7/j/iUfrFXN8rqd6aIJVf8/8yjs0wqmzRn7TxrjXOJf9FiOV64IsIpbKwQQ4+MyKyQRRExznxSVMKzK8h8oBq1uh/xpHVYb2Piv+bd4fsDIJ9nhmy/x4jyQk9T8dqVlm3tsBrsWwKf8B/oQxVryuk5vExw6eujUB8Gx1n9++opQQYZX3+iwJ+S5zGLNPaSaD8UL1oFgc4NnwJcq3HF4/9d1zO+cn8ZVKH4nejO/SG8NADJ+Q4xaBoANCAO8Hwg+Mn0320vR05cqtkD1L0YtBGcCYddb4h6euF3VbBRXsPAmumc/9fQC5rwSEhZdghYtvHCUu/IC/23Q0Bj/076PTpOq7uRMA4K6kMTTSGXR13FwU4FILuV91KOSl77c7UyGc18fW8m8CkfeqYWojRLBYRHk+lfH2X6/slYgEimS3L5TWljjQFIgz+E5SPhr/RMT+l2U3xLK+Nypx59mGUx0qCrBLd3YlKr54P3Ciwd+AkLAqU0eSkHWV+SzZdKN7fE+f3sQnDOf9Wqw4m/aUoQyIk8pvfUUF/d+gZY9a7wlnt0L8aOJvEO2mJA6LXrMLzhsDVlt2nO/M6R25izjapvqenv94g7Fd/knsEzl1V2uol87pozgo2YfyJNiD57hx9+mZocLIJDVL3zxa1kOyGOEbO61Q6nRbDCJmanO7oQk4sjq4ppKrAl0Bxolf6WPvBwFYsKNsQ1iHeMld7igAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

