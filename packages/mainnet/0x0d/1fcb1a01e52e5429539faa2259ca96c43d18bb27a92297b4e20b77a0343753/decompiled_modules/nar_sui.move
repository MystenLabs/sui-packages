module 0xd1fcb1a01e52e5429539faa2259ca96c43d18bb27a92297b4e20b77a0343753::nar_sui {
    struct NAR_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAR_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAR_SUI>(arg0, 9, b"narSUI", b"Naruto Staked SUI", b"Test Sui for education", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRvoEAABXRUJQVlA4IO4EAADQGwCdASqAAIAAPm00lUikIqImJhK6AMANiUDfEKB/VUyaXy/BqfBs1uBdyznsp/a/ptNNL3oxgULwkkTmne/M9VJnd2bXFXu3hB6vDL2XAqUOkdoFAnZb5vnhvnCW9GuvfOvx/SsNE5xDIIS5FziBTQzGmACm3x08NahNW2YYPnFalSRv6w2X7JhCqYK+jupobqbsqVNKcSuZe7t/xr8SiVsAx+j585/SXYJliUZafLRFSbQfrbU9iUCZfUGjlCLEjUXSzvqz+ttG66871LGYg7rygcUx7fkW3nFZG7fr6qTVt6AHJgAA/vxVMlzZbIIpVwoUb1coY4ucc+M18WuTj0FxvkCCzyN3AYlJ0CmEKHG0JNg5F347TAZa2FI/JCv6JGpadimE5MLOm8nbn80ac71irOnrUXwOY0ojIkkCUcksmmwd51M99vLP2m4UVNs5dyKADe3Fwv1P085chtHEUMJp/Ai0IN8spQpqaK0u43JkG8KlAyx2SdcQQglYHkRI9uRPuux0fr9Bnugxuj/HGM/JA3fFZ68NCYh8hOchhz93oySU3NCMH9vIKGXgfaJoiyhImfF5soRhFmDuE2/ZsICh9e448aX0+ZOl4lSikGeQlvCHkgl2862jkVt0lD+H260RmmpYZpspsusflhSSdOvxPU3t5OTZRVCLHL/cir4tuQwofehqXW5xP7iWrPLWzYtj5M2LAymRXbG4NpT11gSqn6qdpIhXDOVLszS3/yAiH5QfEXRkCf/d3FFBeXRSTkRVSa5AMZiNvmAtFbIT7PtzjUgtTYQ4vfuvoxILQhWd9i5otL1JXU6qyLuG9WQkC/p9l+rJTjFrBwI5rmdBaGIhCB0mwXHYurNsCHOr/cm8Hk0Dn6RmP8U9dakpzw/v1Ob12YiBmTJuw5BWurCa4CClfSk8Nupc+JSYi8hF4HorxEqhIxDI5DTyLGiEnr3H2b2y/ph/0UJmualTDNtnQ5hukAfBHldLs5B+eBAdvR+KBu5aRq+o3+FlHF+jjQlemTsmY6zi0pruMQdv2ydo/p71Jr+DufYIR8RLUzp5wmv+/Hm60GoedJVr6vscXRZNUA8J9UeC2HjIlrO244euGZ4zMoCrDydzaLtUweYNk3WWbqb4HQazKG7tZVhTSrmgLNVL3EoQJomZAEm22B/XyICX5d6Eezj7+HpdzfWm3S1MwiECnAkpEzllvTCZt9SULsNsofsYsLWz4Eap4GXkc/gkfmTDckpaLFK1eUr+BMPakDbkGq08Wq9N2gshUYYi27o4HdG3qvMVzUwBXMgEeAv7yrRUdMAzPY5z5QhD5BExAjudMjS5YRVhHJ6iP5FaHomrGimZlMXJmstN99tXpWmuKiXEBhEdE8bvsZvJoMj/nFXBWsc+5jdj+HnPSyxDjfdqNo00pWWZ8jmvA2tXG58dITm+UQu8sZyDqPum1Vrlk/cP4cGIzoRu4zkFWp1FRkAAXv5w0PovTvhCzPeoc9fLRFPaKYhKpB7rW4mNe/mjTpNZYVIUO8MBLI4rvjK13hFg4DUuUzOCLzRZvoHNDSNGNkjk4zWOpCyaozKb24XtAGotw+k6LGDBG5+BbjviEHVRfouC2pPuK7iGSlTv7bjspzgSE8ez5ZTroyNTxDPQSbR4RTE/MTs83LN1zpFhExCYdbRdQzs9oSc8AA==")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAR_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAR_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

