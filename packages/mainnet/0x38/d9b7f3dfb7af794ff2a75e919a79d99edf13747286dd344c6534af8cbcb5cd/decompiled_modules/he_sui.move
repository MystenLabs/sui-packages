module 0x38d9b7f3dfb7af794ff2a75e919a79d99edf13747286dd344c6534af8cbcb5cd::he_sui {
    struct HE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HE_SUI>(arg0, 9, b"heSUI", b"he Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRtgEAABXRUJQVlA4IMwEAADQFwCdASqAAIAAPm02l0ikIyIhJZXYwIANiWNu4XPw2IAGvauY+F4VkjUIDbGftr0UH6V+6r+4eZL1ifo2dLHfku3P4cvJntHyTmXmI5lKORVt1sB6AfVnoL76ePD0G87j1J6NfW0GoRbKTOi+qrVUHX1JjkkTq7widi5ox8yULHOsVY/47GrPBsCyGO+7KZdTwZQsTkS3XhyztQC0qowHXI7IMtAiWZeexie6oPz/yEDFueYkAaq0pCkU1aaWg+khH/KQ+LgAAP7/dmD5fDMxTzaJ5Obu8cC3RMjL+u/3+adwVGp//PuzE/rBvUkL9bKA1PxR8MwIuwY7R70EFZnb+b2+jHCWZDuEyLf+zCv+2ySE6LZ8Jnh1MuPvH855ATa//qqdcsVrb1x/flqwTkJNxktwHB/pS+Q/VqdPYuAPxiQoB+5ULanN0zafGfLW+vaIV5JfmCJGreYfPti+3BebvszuXDklsBQ553upiNPAXMW+IvYzc7dx/8qiYcKo3JmOlXR2mOI7RosNj6K4tlBN4d8jmFaNTQMy+NT4jpfr/7owz1ZVFizVDC43P5M3w+2E3qqpSMG8C6duZqvmsGwwkwlL+z9xq2s/Lyf1xm9uRu4EdWZLHLgAn8TgP/FcjnE+fPga5nlDVvjHbJr7iRcuB41m7fntIxx+oJf3C0oyaL3f7hpT/9XAu773kQXx6fWSSk4bdX9idG+S0JZ1sbiss8PkWyeHsP3x+3yj0DMLWZ6wxYTNas9K/Rxr/KQTEB7mJNEBJf2KF/Gmpm6hlK12fz0l5ilddPRwcnCdwPw67XaRm+6+yclzTfdNRlq36tM2ZRah/9FPAJP9lZuGF/chppXZfHVklKCeUVp67EKMyC7YMeeV7+LyY0qj3DSKsDAwgB5jtDVyjjfBo26w0RrVmSQRyKKpJinfNCrYczOTXn6LiY10/+O4vhjrmVtWVMWlIpCXdsBUrba6xYy/D7jN++Rl4DakhB9l223BDvNu/BmDBvgRZjbPlA90Y/WnY3F6mNR2eWJgZnERRaRTIU+CeCwSMYUVNlIyemPhBs5QTSy8PXW848/6b8vm23J8ItPAIjnDUvq2LNjKE2ob+ouLd3K9I+MBL1hhN2o8RH3bnba/WD7Hiifn3mrIpnoX2rtfWPsgcfVLvbrjobOahe7y7l660t94V4gEjgLvxuvQvRkeNyDU5+GruiXpmP6BXE7uDCN5SBYDYVmmlgG1i6n+wI0ZlakzLL1hDTdjW2Ln4BFsEA/TIFaL4Q585gGB3lRFjPG1akZ6CCAm0tHuX6LfCXNF295yUQNH5q2iHogqT03VdxFLIH+PlhxEhRznKXCZ8w382+NlicC4X3cu/zNdJlulpzBjQ/ib3S5DdDsNX+wL9778CdzZH79sdkDy1UjNCn6RdRY/5W7ww2HYgFwiJi1DoJqz9R6UO64/3XFLfnt+fnrDpgHhggDdNYU5A4fNrZW1NDcrp3xKGoWF+ZzxP53HgfVpR8RBxx8ONVGDxUzUL44ZzsbIXfJ8oI6OY8r6fVs4qqCwZRiSWnRe5Lgi9fxej5xGH9PkxrbkFR5G8fbPRFt8GuIvnbnPnivaXWGje/icXX4dViNHM8VJAAH/uIFOVStmKJ5CAAAA")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HE_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HE_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

