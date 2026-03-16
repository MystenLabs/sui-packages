module 0xa6efe91b61aa980421ffc82c52127b315dcec4dc086b9c130bface85516c3be7::arch_sui {
    struct ARCH_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARCH_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARCH_SUI>(arg0, 9, b"archSUI", b"Arch Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRl4FAABXRUJQVlA4IFIFAABwGACdASqAAIAAPm02lkgkIyehJRmZ6PANiWMNuiW2Dnav99XaA9AG3Q53D0H7zT6AHSy5FHtayJhVrh978rFgVpU9AD86+iRoB+oPYL6WXouEk52+95VaYpFEyf0fvohvvPn6IT0MqXUxK3wT5FUgjOsYLy0EHB49K5r1p9OatKddoRQS/4ToOQE+4/Sop4ybKBeo/pyrSPgcm0o18eRf2RtbhHTDIjtq03Zu9nlkty96XgOkq5Mnk0a6cQB6mWRSuy2vMicX7a2AiAAA/vm9+ZLV2RwviSPqZCm/CGpG0M84Ri/VvV728xrgxKzKxfn/3dtPVnO6+77V6yRdh9+fv+xvw3GhdOP13K9nQo56odJ/Jzf5sEDLbk9O5o7dQW7vfEXmnXoe3tdTm5RmBP4HVcP4Bmy9Uy+u02WxMjb6+1Rf7lWZrMAsoSER1+bLYO98KXCKI2c39R9VDthqWrlH58ReYgHu4+qz/4JTcryRqjqGF/3dGYITPB7ocGNqGGz1/uc3eb3vTWaESlkMF/7wLzab1f3Nqhp2s3lrnKJULpDbTZAIcrp01XoVO6Sct+FZmk1QO54MQkVZzQeCLg4HLlh42EzR0h5FcJS7yvCUeA9jlZ0NQcF2xuc3r6HrxsfNUhYUYDOYbE6v5n/yQvh+81BFSdNro+q3qHmzSMcH0t9+//U9Pm1a49cNZIHRMA2GWx44cLfufjUzCvNQXAJFG6/q+B3m19OULGIC7Nu9Wjst6kqcKzrCWymd+Uk7/yn5MSFbPf/f9bZ7K98kEijn2zv8xZVrVbZsEPSwjvqzqHzEOpZRVKHhSGS1Wg59H8nEnFYO8mJGkUQ1S42JCr0xQxg7PL3IeZD9O+Q0CKpRXefaOUHpl/3+hCY6TqX4h3cGcbaQdeeOSosyPkIOTQsXxu4bOp5yWE9p1ilAUn4BnGToBswZ5yINlj6wLqizrs4BhzKh1b8NexUikV/MX97fp9/PEYiSEqrsoFLoYOENW1uzxF0yZ5cuBXDluGooWSJFU0QDW78xamXYyvSbELcZfGb2Y6Pffp0B01Wj/2SGaor2F8Kr1F9INw1G1JTHlCxYXmbKyq229iwIzXuWHrv+HIM8Z/LInMPeOJa3puiHWnkp38NTdcYeKtzSVYaKJV1/WfaOHM9mfvSOgK/8B4jRL/F6iFAYfAR3M2gbma59vKP2sokbNte/Q+2yb6/PBhdqG6FNobLyylscgrsC6p0LF15x3PDXxVtAJulD9VQ2zTQ70jfdH0EYTKvpzlzZ9O4iO4BdvOJI/w9JH1CzuYI06+HsgQX+JaORQFqzlFXn8ykZDHIxFgjTPmXQC93izdPvVcz3kfBqMNlKEAOKvFZLQAH5vO288HGWLFDy7OT4N/a8G9zN861CH5kJBKOzaUSgGySH8XFFnlztCaFN6o/xvWATU8O5Py4qsxPH0gZ7sbYn6MMdvPwusITy4yX7LD8F+P3yTe9uS+V3Y7/dI3z7v42bZru5nlhPp1KT6IXwQSH+6P6vHomFU4i/0wQWDOd3sI7k3OyI6rmicxu9OdgskECM1mmioWnQ1cKtHdKe7eefe7Iz3xx/G4vSn+bexNH5XGykLErgD0ye52qFJHqx0YGGswWT8JQFHpJHGideNzjK6W3vbywW4/jbeuaGu3guWJ9GvALUtrvYMvrw0tQYhAMMrJEs8yUx/eqE6CpzgMZM4WDHzcwKphBOFkEOKndpaVyE45/3R7fFXluiI9MNeygHODo3sXSejQiwd+/LTzhGsapvM0Patl0lfsguO4MR6mmi8z6ziqi8cmqZO0KAAAA=")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARCH_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARCH_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

