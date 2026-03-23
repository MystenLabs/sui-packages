module 0x244be358e5e5c22ae4cc3335af540ac65409f565a39b60e8f27bd08edfd2b705::fuel {
    struct FUEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<FUEL>(arg0, 6, b"FUEL", b"Fuel injection ", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRnIDAABXRUJQVlA4WAoAAAAQAAAAPwAAPwAAQUxQSKwAAAABX2CQbeTYGXwRhvARESv+CMCubQdRdXEJ1g8lUALNUAJ9aJ5LymMmuXeefkb0fwKQj0bQI8k5RLpP8ChaaRPlUhALzrCUB9UyQU44y9qC3uI860oIG1xhdw+ykAJwzVRmwKssxB1wlX1/od7L/n+3rrJvbwYVOvCoMcC/1hCABgBcYd2AAo3OM9mkCTy0OsvawELSOdMMnGHIM1CtoXys9GtADtzECfSXux3yVlA4IKACAABQEwCdASpAAEAAPm0ylUckIyIhJhVcSIANiWwAp03afgHSmYg7F+O3sqWn+xfdnkYaT/0/8e/B3eAP0t/DnhAfp7/sP8ZwgH6Y+gB7KvoAfsd6Q368/A3+yn7R/AH/IP6X/9/3bzyX6ANEAfQMcl/x/IFQAepr9VfY5/SU6VkuAVkxSKCzOYkEEwRT+efxJelmXTLgI0M7Eb3s+nx/nq8FcsAAAP7bD//uJ//7hf//7gC2l8Fuk4ECjxmyPSR6vZN6SS1f/kQErFI4/cE09+qpIB1UFZqZQjpCgAUrj0NxKLcZOkbGrF2Z9uwTHm9wI0oPyNI8YI28LS6UXHAxC9/CQYjnF5XcZUzUfuguj8Ru7YSuViqj+Su7bAhkOeHTSFpmWaULUREuBkO3nZBYmYdAKU2UfZvgsD6P81o6Y/N7DLKjFPObFej/Xmka59xy/4UVvSBe3D91prpibcvEIY5f+Zf43zYtDIhLPbSXuw8E/hHUlyJVFFxd0VKHryJi+4KnRb4gtcSV8o70bAnjvp471ZTYNmVbmqRmwbMqYiXe0i4ZYSbQNwjui43+UN9cyYBAP+HnBX4+ftkIYvnfyby0xJ3Hs5qQqEPVF8x/Bi+qV+yVggPCU1xEbSJscamPXweb/V3OU+nPE5sRNV35ASREGBcJazVjU6ouH+ktn/e7v+eneIwp+pDMS1b8VIvOQ3sGzK2K6RbU//Kbkcg16OyXINK5daHBgUPxLEpqLn/5cVyU00VnjFadgLoIouDAqHvEyVs74kYXJOY4k36/Pttv5SIJqXTFx4r0CMWtSQYI93C5qhNKE+U1BPUj+Y510B8lwLfZZJbteEbqnNmj/TeSNVK0Ng2PS13GMk/1jY40VcFm3U4s8zzPiPQm7gAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

