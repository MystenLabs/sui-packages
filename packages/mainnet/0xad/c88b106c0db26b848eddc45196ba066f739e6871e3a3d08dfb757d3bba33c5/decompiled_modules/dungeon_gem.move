module 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_gem {
    struct Gem has store, key {
        id: 0x2::object::UID,
        rarity: u64,
        rarity_string: 0x1::string::String,
        rarity_color: 0x1::string::String,
        effect_string: 0x1::string::String,
    }

    struct GemCirculation has store, key {
        id: 0x2::object::UID,
        circulation: vector<u64>,
    }

    struct DUNGEON_GEM has drop {
        dummy_field: bool,
    }

    public fun calculate_upgrade_level(arg0: u64) : u64 {
        (arg0 + 1) * 2
    }

    public fun create_display<T0: key>(arg0: &0x2::package::UpgradeCap, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"effect"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rarity_color"));
        let v2 = b"data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20version%3D%221.1%22%20width%3D%22272px%22%20height%3D%22272px%22%20viewBox%3D%220%200%2034%2034%22%20shape-rendering%3D%22crispEdges%22%20style%3D%22background%3A%23483B3A%3B%22%3E%0A%20%20%3Cdefs%3E%0A%20%20%20%20%3Cstyle%3E%40font-face%20%7Bfont-family%3A%20'pf'%3Bsrc%3A%0A%20%20%20%20%20%20url('data%3Afont%2Fwoff2%3Bcharset%3Dutf-8%3Bbase64%2Cd09GMgABAAAAAAdMAA4AAAAAEZgAAAb6AAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGhYGVgBsCC4JFAqXRJVPCywAATYCJANMBCAFhEUHTAw%2BG30PEdWkpsi%2BHLCN2WA9AePs0LRCSlMdNbQONgR393U5xl0uaPAhGh9iuHSYbrY7ePBfN%2F5sVr%2F3v3VPOiffF3fJMamYNBKUojy1FoVD%2BKTIdutvreX%2BWyD1kjRjSTIp4KOkkBTIqKpWmNq3vpTMlIeHa77LZeIRDqFKaKLzKPMR%2FEG7TF5KDnxVfLIAxwc8l9PSVfNW5780jlPOEsEIq3Xgw%2FdCuPi%2FtTSSQTHKCJN3MrhCx5ibP7d%2FB0I0eyGUwIrBqOjIvDiGsiISHoVpVX1VOwzPwLMRlzgQBNAhXkRAEDsQlLP4PQfkSPoM%2BM7pzZ%2BUqIA5MDz2rUvXMQNJfJr%2BGQD5kwK2vAdQgDsqxUGGZ55ngxUUglNwPq7FA6YtWAKBpMslrvO%2Fc%2FydNcqhIEJBZ8fwf2mAafGTJT1%2B9tx%2BXPHLr8j%2FL7z6MVf%2B%2FD509tL7t4hxC3HBp5PJV52%2BM5M4SEwe7E5kAQDsudN5%2B1wE8CSADwBnMiD9yg9FCEprcAgUkF6i26EwHNOth%2FmElc%2BM5CrEd05HzhvDUPGfaj7steb16cbGyoqK9rpWQdXGhiYVtTWvaI5BNNYnEOAbg5010fMkKzrkz9M38LQ0VFRWNjY%2Bz8Eug09WtCfY8XpS0WKCBSxoCSH8HRnbGuvb8skaHAkGhbaaoNX2ZxoF9hoboRCt9rqTV%2BKpCsrasGJQfUDvDNeSPU8jxGdI8au9Oub1prVWaX0hXpeCIfGkINmvu%2FlP%2FLOYNnSZiNXILWBPPd83n0FHBYvZlFt%2B%2BZSFSUGxEDYBvsosvE4pIxGExSA%2Fft1RRFoRlFBIMId09YVIaJiQQTbwjd50CDRabeWDFfODC3UCWEOlSHU2BRA9840%2By5V6jUomnq849outSRBlK0UfxDaLrS%2FcbCGpEoIa%2BRq7x5E6lIEGgt976ovV4IYHbYOUicAibJatfz%2BCYwxwSwVzvqVIMiPCTcUtkCIoVJC465z3J8zNN%2BQ70X%2Bd0bUSMF4aLr3Ed%2B87IwD53nf2Pm85W20Q9RHyQbodpGDvtwxttaiSWwcIdywc2gk2ik729fAi5QdsepM1RXfpX8jHFV4h2hy10GHttuRk6mLhwsiju6kjustkydpq0hB6X5TNItIpXpKKtDTVuJXLaiDLiFsSux6MLZ4LdbgYA4At0KhwicPc3JArlKdY4y0tHCK%2FqNVdLbjGGi2xTMVoC2XEg0a7eOGRhaPMgBpg47L5mQLc0SuMp9iSnQ0uc3RvMdIus9kMluTo1DzLzmUnw4PtHCm0VV3srbnaMqmwTp9DFdELF2X0ljWtkNTCtUzZi6AZEMcbjY4b5Uv2AZf2WWVRGeSbJJGUHOoxR9NqunSRLW0KgtiiyZVRXbe0SugM6pjq%2BmgrgTin%2FUcPLkKdYWs8rQYPKXJ%2BEkimRMawtujbWeKctyzWtyRgShnxzk016EjlGF4aM6NPNcB0mc9yBU8wrZi3osAyJCE3Ftico6VbI0YDGxha6JT1dxPGimO14V4j72m9wtsxj%2BXVObnFcUYRrrF0SyKdwjKvjh8F87gxj0xTnOByQtH6WACWHK5JbsYEaxZFtFMEi1Bz1HylGtrF0XWZTWtXTGfZsWSZEJKB1RAO43pz5iu%2FceNzSVtxFDlnYH1smpid5fSZVFhZS9KwpTfNk3XwMkXJ0XQ6iubBuWbKZewSYwrG%2BbUIEzBGEm29h6I2TNXCh82ZscZSlZIjRpcU2jWLczULHZ9sfkVm0aV%2Fgk29pBpTG1REJrgoZz2TZatw4kwvO20mpzdcglNuBdHcB7WqCm%2FkpOamKrXQhy0SHKkT2ZK%2B7pIuaHKNB8pKQohUjl2hodWst7aUDQw81t3CI5fJmPZYNPhSMTT%2FCIAAws9H%2FvkddMMPq%2FQPgB9v%2FaPOOQcK%2BUD%2BBJlAzcZWvKNa2XFUqdbJ%2F%2BKIg0WoxQ54QdNHWJuhXoiAvTFyACCyW2gAr3ihMkw%2FoIYrgSCR3JWJIrkuUZ1qdb5VTnSnS8oodZAU8wLgXXcokar%2FEsV0NFHdkbT5hhLdPcnDIhCcmIATkyfYxwadYmHsvVa%2BUKnVwn0dnpV0K%2Bc5aSQuvuHNKk1bsX78wOqyZM36s2OLD%2F8RhZ6i6byrVq19lKou0xyrzu7cGxPTL1vmtmlpXF7gFExVYeDi6HEbY%2Be9BzqKCl5sTUvesdIR1Cr1dvBYkS7Nc0jZpHLFFSR7mt3GgfYqqrOpacolZLIDPWcyckyVJTA%2FtHiKQ%2BNnZaQVJIzZUlPt3Fk5TQl1eRlNY2yr056xls0Z5u4cGP1cvCREoQcjtJL9EbH%2Fl2mLxmBxeAKRkYmdk5dPwO1CX0rOqiIkwOsPHtxNvrPBR3%2B43YXFZwqp7maJPm8Rd76zAQA%3D')%0A%20%20%20%20%20%20format('woff2')%3Bfont-weight%3A%20normal%3Bfont-style%3A%20normal%3B%7D%20%23text%0A%20%20%20%20%20%20%7Bfill%3A%23";
        0x1::vector::append<u8>(&mut v2, b"{rarity_color}");
        0x1::vector::append<u8>(&mut v2, b"%3Bposition%3Afixed%3Bfont-family%3A'pf'%7D%3C%2Fstyle%3E%0A%20%20%3C%2Fdefs%3E%0A%20%20%3Ctext%20id%3D%22text%22%20x%3D%222%22%20y%3D%225%22%20font-size%3D%224px%22%3E");
        0x1::vector::append<u8>(&mut v2, b"{effect_string}");
        0x1::vector::append<u8>(&mut v2, b"%3C%2Ftext%3E%0A%20%20%3Ctext%20id%3D%22text%22%20x%3D%2232.5%22%20y%3D%225%22%20font-size%3D%224px%22%20text-anchor%3D%22end%22%3E");
        0x1::vector::append<u8>(&mut v2, b"{rarity_string}");
        0x1::vector::append<u8>(&mut v2, b"%3C%2Ftext%3E%0A%20%20%3Cpath%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20fill%3D%22url(%23pattern0)%22%20d%3D%22M0%200h256v256H0z%22%2F%3E%0A%20%20%3Cpattern%20id%3D%22pattern0%22%20patternContentUnits%3D%22objectBoundingBox%22%20width%3D%221%22%20height%3D%221%22%3E%3Cuse%20xmlns%3Axlink%3D%22http%3A%2F%2Fwww.w3.org%2F1999%2Fxlink%22%20xlink%3Ahref%3D%22%23image0%22%20transform%3D%22scale(3)%22%2F%3E%3C%2Fpattern%3E%3Cimage%20xmlns%3Axlink%3D%22http%3A%2F%2Fwww.w3.org%2F1999%2Fxlink%22%20id%3D%22image0%22%20width%3D%2224%22%20height%3D%2224%22%20x%3D%225%22%20y%3D%228%22%20image-rendering%3D%22pixelated%22%20xlink%3Ahref%3D%22data%3Aimage%2Fpng%3Bbase64%2CiVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAWdJREFUSInNVa1uAkEQnmtq0Iche%2B9RheobkOo2tRhc34D6M9TWg6wE0cMRautA7QiSO1Nzciqa2c4t%2BweIdpLLkWXn%2B5md2QP4j5ErRRcBtFh6AXKliIjIR%2BLNDYEyMD9MkOIks8F7apLZwAAAtdawWK%2FM%2Bt3wFgAA%2BkVh1hrETm7UAauVinOlaF4tzbr8fdLZhEohiefV0uyJldkJHtpjO3Ttu0p1ZKtrELMGMZNnkBQu9S2WxE9qDkeSA%2B4su8POipT6A%2FyWLHV%2FkCQ0VBcRcCLXX4LYU%2B1yByDOQC5ydyzWK9CbJ5P4Ob4xwLXWUGsN%2FaLoTDDj8Nt7VbAqJvh6fYdqOD66IlzXQ4slHTWEJOGyzLY7OkxHdJiOOleFq94nTTGDc9w%2F76nF0hD5wF0k0Tl4%2BdgH%2F5fl6KlJFnUiHcy2u6j6mINrH9Hj4O3n%2FRDUA1J58qTL3vepTz1UL6MNGPxa%2FWV8AznvjmPePrDoAAAAAElFTkSuQmCC%22%2F%3E%0A%20%20%3CforeignObject%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2234%22%20height%3D%2234%22%3E%0A%20%20%20%20%3Cdiv%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F1999%2Fxhtml%22%20style%3D%22border%3A1px%20solid%20%23");
        0x1::vector::append<u8>(&mut v2, b"{rarity_color}");
        0x1::vector::append<u8>(&mut v2, b"%3Bwidth%3A32px%3Bheight%3A32px%3B%22%3E%3C%2Fdiv%3E%0A%20%20%3C%2FforeignObject%3E%0A%3C%2Fsvg%3E");
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(v2));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{effect_string}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{rarity_string}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{rarity_color}"));
        let v5 = 0x2::display::new_with_fields<T0>(arg1, v0, v3, arg2);
        0x2::display::update_version<T0>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<T0>>(v5, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun create_gem(arg0: &mut GemCirculation, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : Gem {
        increase_circulation(arg0, arg1);
        Gem{
            id            : 0x2::object::new(arg5),
            rarity        : arg1,
            rarity_string : arg2,
            rarity_color  : arg3,
            effect_string : arg4,
        }
    }

    public fun gem_rarity(arg0: &Gem) : u64 {
        arg0.rarity
    }

    public fun get_all_circulation(arg0: &GemCirculation) : vector<u64> {
        arg0.circulation
    }

    public fun get_circulation(arg0: &GemCirculation, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.circulation, arg1)
    }

    public fun get_unequip_fee(arg0: u64) : u64 {
        if (arg0 == 0) {
            8000000000
        } else if (arg0 == 1) {
            16000000000
        } else if (arg0 == 2) {
            24000000000
        } else if (arg0 == 3) {
            32000000000
        } else {
            40000000000
        }
    }

    public(friend) fun increase_circulation(arg0: &mut GemCirculation, arg1: u64) {
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.circulation, arg1);
        *v0 = *v0 + 1;
    }

    entry fun init_circulation(arg0: &0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GemCirculation{
            id          : 0x2::object::new(arg1),
            circulation : vector[0, 0, 0, 0, 0],
        };
        0x2::transfer::share_object<GemCirculation>(v0);
    }

    // decompiled from Move bytecode v6
}

