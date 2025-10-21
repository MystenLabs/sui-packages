module 0xd225dee9e2723b38d8162dbdb4c85a9958359d98069865f7527f9e6092c5d980::mmt {
    struct MMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<MMT>(arg0, 6, b"MMT", b"Momentum", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRkoEAABXRUJQVlA4ID4EAAAwGgCdASqAAIAAPm00lEekIyIhKpSYMIANiUAa6zovzPTluy/iz+WnT47bd6/yF+Gf9A0zrj7/AfbT7q/617APs59wD9Xek75gP0T/RX3qP7N+qvus/WH2AP0l6wD0AP3V9KX2U/K8zVDrvrru4l8G5Ur9e8t6gSoJ852Mi7LDo+11z+VC4nZWxuWe7EepE1kzyF0/ydLucF1VFlDybIJiWdYnBAJhcCsBxJKZrT5p5/M89xIZ0WtqkjnOK13k8g3He5ukbglDt1l+yx0sRhAp1D4HMJZRPT2A4AD+15X+0XVTmnjC/3mLwB3tvCAAAdyl0JBenJx3gtG3mQa1++1m/ITdwDAZHGzkPnQLqcFYAzxip/BRM3Zz+XQe5vcIovlS67lckxfclg6Ya7YGIoOq5eyUtnKh5LGA0bjgGbmI3H6JhdSfPN3FF5e73uvQBcOxf61jH3D6FHQq6oj+ZA4At6y59IJaVZziAOzl5O8SoMNPCiHkxPV4AXM0KgNxNI94EgD7dhXX8O7XwckkDp/4dO4shXdulzleEaoKDe7dQol9JXM9wliWcwpLQWcqD51+vCYfQWfVwN8oRaLTnS94o3ymsyC/7RGSPqOARhronSMHBC18vSRQEL2OqEykvjz4IpNv9UZ5nUoDxDHVEvJrGO8rQFY4X/a6A71AaUHkqa3USiW4oUXu4MiLsr8iwsW77+t+0quzTriTdV6zg0Lf03xkKxgU3Je62UErkjlPBcBBBnWx5L8j9t835Fq/aiWxhQAonHRo6E+kurwuctmPYASX5dt1I6OVRVySPx6PSIuI2wtJcL08BaqR+azkt1Kp/ZQ8nt6ghrgxgoQ+ZHS8Adf5fieSrkLYnWEfUEIiREOaClUUC0UFDxOyCQtBcdllws+OGe76MKkVeBh+frJU9k4941g3hnJa8MzaBL7AIfVLaGg9MzqxG5hHsfccRutRDIa8xyRvaeAYe3+G+pTAGnDL+x1/LC1qfXFp6jKN3ycQw8WnC6QiB5LsPGNiAlal0Rp0KvPp/8bWv3/6gshILl2phJJ+e+EROj3D0X9Tz2Rnzn8N1OE38E53/Ic9YEY/dht558Rp/KLu8p6yHob5TPo6KzXJyTwdIRLz0yJoRf6eKPFzugkiyLsQdSUm0dYd4Z0xb1lz6PzUIeibRJMyMB0vIaYaeFbYfqTDZGWzGLJXcP3v/VQBBTjP0GWlRHzQKlDw9jvhTYytc3C+EIbsaTQ6qFFNvCDbvz7OE2yS1SUjD4q0C5E9HVKpDtUntfedc3oFeTXoBpdVA13+gEb+b2S1egAY6ID3DGot7sKTL77C5w5rR5PEXavsKgiYq5vSCvkrLixdrRW+JEgvJ69lV+bIb56GgM2rWFBg+epkb/0K5/xpT8RycH9e27Qn5KCY8fjoZ0gPSXxKqL5Jl8N0V7zTWaUQiNzgAAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

