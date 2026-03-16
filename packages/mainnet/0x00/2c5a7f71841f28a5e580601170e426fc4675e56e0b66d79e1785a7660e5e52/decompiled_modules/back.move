module 0x2c5a7f71841f28a5e580601170e426fc4675e56e0b66d79e1785a7660e5e52::back {
    struct BACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<BACK>(arg0, 6, b"BACK", b"BACKPACK", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRvYCAABXRUJQVlA4IOoCAACQFQCdASqAAIAAPm00lUekIyIhKxF4MIANiUAa48Anvf1H8Y/yA6W/cLwRyhpy+z3Hd6gPuO9S3+3fZB3D/Mj+wHq0fgB2AH7d9Y96AH6gdab+2/pAJ6lAsb9mMzavN3vGoDUtnZkJezlIjq1PUsr2ta2Y4FiQp7DtTHDvGjZCkJ42B/x/MlgoGIuxuKxnBwaun7J7c+GFTO94S3Lwxy7fjQZp8qgycMqPdJdsHxty09ebveMgAP78+EAAyPQVsVeC4/UR8VZTxr33i3nC4JTBXD9JAKQ+Qez82cAg0esC77R0d8eOWhsz61ulhLxd0fzZjetV298DAGzN9bD+UTmWMNGnEqnLbrSIn/x2/5VOo/40b2vV6rz+Px8aDLXd5yQkCyeDkKXkqTOMPXPHLUuO1uYbbqEFT4kDXmvCSY3dKHGWCOD/opvfKJzsdd6Nznl6Ky4jLqZm/rHAzkp3wAlq1rucTleZm3uwZq5kLRKpkyt7xWNQVN5m+nfeBMk7VTjjDTBaeEnwhVF6BjTgHYtfWXgumAMKBWH/2+oiSj8j+Jr8/+NW0SFXExnduLI9Ye4QBGonFDb+rulkIK8vpx2Wwr2TJaaQ/+WUsZOvP2lwwcQBUyQDjxwnN7S96ckB1jb99rIVpCeDFJIs4rR+OG/wE3oVUEs/Uj3TDTAju26ii7dNO3rPsunDFfjO4jPceAETf5YuB3baHD+mfmKF/+aI4qHYH3C7MI6sP7anNl1J6AZpk+VklzqIsyBVn+NYjcfwKVd8/myPXpqWT9/FLLV1TwSVRBiuygEAXXUycZf9xfoLQGrP4vVsQWTW9ECcNF3oNSVKE5IBJefUJFb4qO/BQhCUgLGyQwqq6avw7SblAZ0eJDk2chlOYdojePSl2JV60BRP5rqY5ymy4MpkQdTzqeCPRKhn9QNXy6PFdMDb1WjpCgsVxpACOH0EIE5+EFvNhJMLM1dvErig8GlQuQSiV91hfcyYAAAAAA=="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

