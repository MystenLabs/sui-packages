module 0xcd716fb4cb005b442de7cf3b663c38557545da48fc448fc4ece4f8a6ef49e8bf::sail {
    struct SAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<SAIL>(arg0, 6, b"SAIL", b"Sail", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRuwBAABXRUJQVlA4IOABAACQDwCdASqAAIAAPm02mUikIyKhI5bZQIANiWkKFqQVwq6Op9isoGGCnRP7Hxg/le+V/U0XfZxUHVr5f2HyY7VPAvMPD8C39iZOj8sA078RAls4q57LVCg5exqAytdd9sAdoems/DB5tz5HiKu/vKx4zFYzn6x/XxirelioC/s4qDq18v4gAP7/angFz/4J7Y+HNtzyoH3kMBp6v3GMrX+sv/LvB6vffe4AT8O+Isata9vi+a1mfX4RCo+Cy9D6jKtFjNeyNocZU4LxbaJQUXMoP+8Or6UfoIZhdYbiS6Ui0xKvlwTRZDerd5rYIhZ2l4ScDfBKCw9iPe63vNDxHRrI8xZiFbvvgk9/TxqJ0Sl7HBYbBJb3ma9/B4+U2sU92+Ec9rZJsd/N+i793X+p270O11kZ2W535RSB6pixsdnkjBw+M8NTN0lR+KZE20wm6YSg1UXFyCh/jD0+Ohy/wy/8nzJA/8s9PI7bnbF2JgBYxpHFClSdbDoqnQB0jkVE0JHA/K9PG5oACyasGM6jen/xuuNlPKUMYvDxNJpP7598XleCZjnOkP4NNcWBi3ntcI/zTM5vWkICTDQMfA6lazR8JQMc1JEAmNv5aWMaTNwrbU0H99pTawiwIIH3dAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

