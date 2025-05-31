module 0xf56fff6dfbc26b380ae07c4effcf230a71dc80d5625258208e5de1a46b5a8c10::vik {
    struct VIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<VIK>(arg0, 6, b"VIK", b"viks", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRrgDAABXRUJQVlA4IKwDAADwEwCdASqAAIAAPm02lkgkIyIhJBgKAIANiWMKFshKgDoE9GG2N52jpAP1d60j0APLU/ZX4Vv3F9GOK/VCcBMsBgBpgJnnkxTSXQp/KgzC5dp18UOa1EGlVfArCEad3Dmru8E2rPUMCSRMFJFEyo/8Mj2wqd3Ebt0t8OI1qzzkT2aXaSFMqdqvOUIBDRppcFC/jwPmsRB5IPo9udJtZc8kCf5ULhNbnAAA/v3ZFf+1Pys9333f/4D+Jf2Bk6AAfM3ortlbb/Y3q/HgCyzXmghq3dnpcj4o2QR7l+1GhAHXpyAz/PgzUvFH8oJx6laj5u8GkRjbb/UAeNuqfTwIr2wr4tXR28r8fsmKqY+5OgwltRXnG+KqRFQYbAx4awXYzTWY/zwBYFV0TXogAmD/S7LW1SrGx0SKR3ffi7bI7TORw5zIOKL5aIPCdmb+HPb/zYQKGbghD8gFycp6Pf3CGsHp//w/+x8cB/wloG74kCaqKc3xrQYGRLZMNfTjdIhDMGUWK0Jt1shpNuxZU3vmVgJN5tRRKy5JyfRexn8d5nAHqgvn7KYLsDgHTD1ovAC8uXnel2R+K+ZJ7PDTHZNpk+BvdqXkfngu35/KnaRkWLb+NEzreLWdjIgPfJ2Xt/d63McwTxz3Zt3mF4lYt9WZCocGNJz2j1xf/6b+MxIj6/EU3zOCzLs+gQsBxi7t/kHpJkAWqI+Fm0Z8CpD4oa+QV+l305X6oA/Wjoq6Vvs0J4l1Tyxzv7fwcFN2NFhLdksXFAagUeRBayy3hwHBfGiHbJHn5VbHoNNNVkPciwpoX1EnL7FQ6ij/7dgMzoc35FkLEdtVevmhBvGE2y7JVGqhgle1QomGRrGVojMhVdmqVg844cc57fyzcUR7BZQtEBbkP2ys/C6rsaBk+gddQqgQiHYZ3EG9HuXiYqHanpSMpkMLW5t6hpvYASe3lrIWcSkPlnv+5i4harZdsISUCtYoyw7YxNY3BS64WLwRr0wSeupeOAmvAox960Q6k/uXFToxHccgyiiHHQsx5jKABF+E6/34CC9espb1dl12rUg4pGZCbkUp4WpVZAGBRdvxZ7YEyX12fr/yLlubGX4W4/fMt689SQ0MHT0AiCScL9xM68zaobG1bAty5qotAmjW+ckAbJzCbJ7IFUgBITINfAJAY6uUODKMdfmIe7zycKusfsixlano4pXojX0o6a3qd1a4bbaGkk8L+yJc+0iWziwAAALxVTEmWSiPUBqUfsAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VIK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

