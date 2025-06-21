module 0x622afb9b42646cdaf832ce7e7db7afe1b9cd31383eefbded9102ee87ea777e64::in_sui {
    struct IN_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IN_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IN_SUI>(arg0, 9, b"inSUI", b"IKANOTE Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRmgDAABXRUJQVlA4IFwDAADwFACdASqAAIAAPm0wlkikIqKhIpZqcIANiWkA12NwDlZPY3IH+yjsR2nP7b+SnDQYr/0NtxmM+OL6Z9gT9Xf+H10/SHIqnm1ebvcxfLjRBHAL2byDT4+aFQYPpDeuQcThY8paXiu4ulCWzInWbZNW7knVPIR+3N8RWwHr8w8HnElFc9GqxMl77P6GedKufkwqXvu96JO3lYJQl3clim+V5o1wwKPE6IucB3k1cMZgAAD++uUuPHAAqdGMarG6P3Y2E/H7qsTF3DWyfxgmb81rO3FxaKpGlYZnHA1qX4yTIbiub8PuKo3DdsFELaUAVpFfdHYytrOWZLD1oyS8bf4kIijhNC/hrWauouE3Jr8pDjietdO68h8xdPH9wnonpPzMPP3K193L011tw74PpOuOTfxtA0vRE7YIaiO5NG9Paqvxjg/4PZMahdFZ1QW0kgSZRsD3o9peC3aK5rgR+q42adxNVRbpAhqQcwOmPdIMkFi1CXdXmDVMZSwurCntdhql4QySn5Lub8ZcSw/U/FPnRT2nhCopfdu1uKW1YgLFez9kS9p7FbORZpjIZ/GYTXH0kr+oiZVF5wpxBDB/kUfDB1UUUHtGWc9HH5y3fdCKsIWQsMkNibfdwgTem0JEdZ7Mebmb+Td6sbz6oa1/IMaZab4SbenTF9Af9JhdZAGv7UBr2jDipQp93HAjrr9IitL/oA9+q+gAvub2sbT7zvAfzuL1nXd6C96Mac6DxR5XM600Xyer48oHBwy/QIVFBGWQrLcUfh6/r1xOppByGioHBPbcz3z/LfJ6taTmdVkeyi7+T9ePzPjColdeVjoAPjEMfl4+0zXhmgpdKD7y96kmX6/8rAjaTs3O4Y98D5MvcAq/66d4t6AOohJYO4KYAlatlCD3dTWMQ9Bphkge2c9fmr6xHxiIfAkZJvYJM8R2bTtPOzZ6a2sZ4O7gfgLaSrU+tRpK6REI7fS5Jl6EPDLhwWtBRJ+Z84ivQBMn/1b3wCRSrH/wajFT2qe+LKklc3EsDvSBWoIzDWINPWlQD22SvvjsOOIoEqtMw07v9i+MJivA6DgaQBFilOb19Tjc1Smy2TFl32OaGM6m1wimUUDv7x0lgQKu0XNkjHTOuRqSfUocA7rQAfvI4AAAAA==")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IN_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IN_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

